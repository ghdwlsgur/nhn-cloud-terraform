variable "config_file" {
  description = "The path of configuration YAML file."
  type        = string
  default     = "./config/config.yaml"
}

locals {
  config = yamldecode(file(var.config_file))
}
