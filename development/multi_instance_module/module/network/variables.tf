variable "security_groups" {
  type = map(string)
}

variable "network" {
  type = map(object({
    name = string
  }))
  default = null
}

variable "machines" {
  type = map(object({
    name              = string
    availability_zone = string
    flavor_name       = string
    nic_ip            = string
    role              = string
  }))
  description = "인스턴스 스펙 (이름, 가용성 영역, 이미지, 사설아이피, 역할)"
  default     = null
}


