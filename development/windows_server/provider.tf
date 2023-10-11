terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack" // 오픈스택
      version = "~> 1.42.0"                              // 1.48.0 버전
    }
  }

  cloud {
    organization = "speedy-engineer"

    workspaces {
      name = "windows"
    }
  }
}


provider "openstack" {
  auth_url  = var.provider_openstack.auth_url
  region    = var.provider_openstack.region
  tenant_id = ""
  user_name = ""
  password  = ""
}
