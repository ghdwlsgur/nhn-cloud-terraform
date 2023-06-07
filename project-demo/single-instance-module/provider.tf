terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.63.0"
    }
  }
}

variable "provider_openstack" {
  type        = map(string)
  description = "nhn cloud acccount access info"

  default = {
    region   = "KR2"
    auth_url = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  }
}

// 설정 
provider "openstack" {
  auth_url  = var.provider_openstack.auth_url
  region    = var.provider_openstack.region
  tenant_id = data.aws_ssm_parameter.tenant_id.value
  user_name = data.aws_ssm_parameter.user_name.value
  password  = data.aws_ssm_parameter.password.value
}
