data "aws_ssm_parameter" "user_name" {
  name = "/nhn-terraform/test/user_name"
}

data "aws_ssm_parameter" "password" {
  name = "/nhn-terraform/test/password"
}

data "aws_ssm_parameter" "tenant_id" {
  name = "/nhn-terraform/test/tenant_id"
}
