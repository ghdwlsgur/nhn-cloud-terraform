module "instance" {
  source           = "./module/instance"
  web_image        = local.config.instance.web_image
  was_image        = local.config.instance.was_image
  waf_image        = local.config.instance.waf_image
  security_groups  = module.security_group.security_groups
  nic_port_ids     = module.network.nic_port_ids
  key_pair         = local.config.instance.key_pair
  machines         = local.config.machines
  nfs_connect_info = local.config.nfs.connect
  block_storage    = local.config.block_storage
}

module "network" {
  source          = "./module/network"
  security_groups = module.security_group.security_groups
  machines        = local.config.machines
  network         = local.config.network
}

module "security_group" {
  source                   = "./module/security_group"
  web_security_group_rules = local.config.web_security_group_rules
  was_security_group_rules = local.config.was_security_group_rules
  waf_security_group_rules = local.config.waf_security_group_rules
}

module "loadbalancer" {
  source        = "./module/loadbalancer"
  subnet_id     = module.network.subnet_id
  lb_local_ipv4 = local.config.lb.local_ipv4
  lb_listener   = local.config.lb_listener
  lb_pool       = local.config.lb_pool
  lb_monitor    = local.config.lb_monitor
  access_ipv4   = module.instance.access_ipv4
  lb_member     = local.config.lb_member
}
