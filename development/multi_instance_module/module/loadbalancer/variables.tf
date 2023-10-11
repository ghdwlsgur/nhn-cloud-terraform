variable "lb_local_ipv4" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "lb_listener" {
  type = map(object({
    name                   = string
    description            = string
    protocol               = string
    protocol_port          = number
    connection_limit       = number
    timeout_client_data    = number
    timeout_member_connect = number
    timeout_member_data    = number
    timeout_tcp_inspect    = number
  }))
  description = "리스너 스펙"
  default     = null
}

variable "lb_pool" {
  type = map(object({
    name        = string
    description = string
    protocol    = string
    lb_method   = string
    type        = string
  }))
  description = "로드밸런서 풀 옵션"
  default     = null
}

variable "lb_monitor" {
  type = map(object({
    name           = string
    type           = string
    delay          = number
    timeout        = number
    max_retries    = number
    url_path       = string
    http_method    = string
    expected_codes = string
  }))
  description = "로드밸런서 헬스체크 옵션"
  default     = null
}

variable "lb_member" {
  type = map(object({
    protocol_port = number
    weight        = number
  }))
}


variable "access_ipv4" {
  type = map(string)
}
