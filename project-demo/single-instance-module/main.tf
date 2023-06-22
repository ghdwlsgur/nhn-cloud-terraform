module "instance" {
  source            = "./module/instance"
  name              = local.config.instance.name
  image             = local.config.instance.image
  availability_zone = local.config.instance.availability_zone
  key_pair          = local.config.instance.key_pair
  flavor_name       = local.config.instance.flavor_name
  vpc_name          = local.config.vpc.name
  subnet_name       = local.config.subnet.name
  nic_ipv4          = local.config.nic.ipv4
  sg_name           = module.security_group.name
  sg_id             = module.security_group.id
  nic_id            = module.network.nic_id
}

module "network" {
  source      = "./module/network"
  vpc_name    = local.config.vpc.name
  subnet_name = local.config.subnet.name
  nic_ipv4    = local.config.nic.ipv4
  sg_id       = module.security_group.id
}

module "security_group" {
  source = "./module/security_group"
}

