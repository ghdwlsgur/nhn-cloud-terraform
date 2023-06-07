module "instance" {
  source            = "./module/instance"
  name              = "Windows"
  image             = "Windows 2022 STD (2023.05.25) KO"
  availability_zone = "kr2-pub-a"
  key_pair          = "hongjinhyeok"
  flavor_name       = "m2.c2m4"
  vpc_name          = var.common_network.vpc_name
  subnet_name       = var.common_network.subnet_name
  nic_ipv4          = var.common_network.nic_ipv4
  sg_name           = module.security_group.name
  sg_id             = module.security_group.id
  nic_id            = module.network.nic_id
}

module "network" {
  source      = "./module/network"
  vpc_name    = var.common_network.vpc_name
  subnet_name = var.common_network.subnet_name
  nic_ipv4    = var.common_network.nic_ipv4
  sg_id       = module.security_group.id
}

module "security_group" {
  source = "./module/security_group"
}

variable "common_network" {
  type = map(string)

  default = {
    vpc_name    = "Default Network"
    subnet_name = "Default Network"
    nic_ipv4    = "192.168.0.10"
  }
}
