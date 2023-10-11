variable "web_security_group_rules" {
  description = "WEB 보안그룹"
  type = map(object({
    description      = string
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
}

variable "was_security_group_rules" {
  description = "WAS 보안그룹"
  type = map(object({
    description      = string
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
}

variable "waf_security_group_rules" {
  description = "WAF 보안그룹"
  type = map(object({
    description      = string
    direction        = string
    ethertype        = string
    protocol         = string
    port_range_min   = number
    port_range_max   = number
    remote_ip_prefix = string
  }))
}
