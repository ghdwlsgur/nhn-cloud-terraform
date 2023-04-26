data "aws_ssm_parameter" "user_name" {
  name = "/nhn-terraform/albert/user_name"
}

data "aws_ssm_parameter" "password" {
  name = "/nhn-terraform/albert/password"
}

data "aws_ssm_parameter" "tenant_id" {
  name = "/nhn-terraform/albert/tenant_id"
}
