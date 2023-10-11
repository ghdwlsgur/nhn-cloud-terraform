
variable "web_image" {
  type        = string
  description = "웹서버 이미지"
}

variable "was_image" {
  type        = string
  description = "WAS서버 이미지"
}

variable "waf_image" {
  type        = string
  description = "WAF서버 이미지"
}

variable "security_groups" {
  type = map(string)
}

variable "nic_port_ids" {
  type        = map(string)
  description = "NIC 아이디 리스트"
}

variable "key_pair" {
  type = string
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

variable "nfs_connect_info" {
  type        = string
  description = "NAS 연결정보"
}

variable "block_storage" {
  type = object({
    delete_on_termination = bool
    volume_size           = number
    volume_type           = string
  })
  default = null
}





