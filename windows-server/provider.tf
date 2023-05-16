terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack" // 오픈스택
      version = "~> 1.48.0"                              // 1.48.0 버전
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.63.0"
    }
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
