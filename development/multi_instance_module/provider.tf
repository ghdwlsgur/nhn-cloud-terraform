terraform {
  required_version = ">= 1.0.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
  }


  cloud {
    organization = "speedy-engineer"

    workspaces {
      name = "multi-instance"
    }
  }

}


provider "openstack" {
  region    = "KR2"
  auth_url  = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  tenant_id = "test"
  user_name = "test"
  password  = "test"
}
