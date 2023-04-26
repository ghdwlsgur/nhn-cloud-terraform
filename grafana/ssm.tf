data "aws_ssm_parameter" "user_name" {
  name = "/nhn-terraform/speedy/user_name"
}

data "aws_ssm_parameter" "password" {
  name = "/nhn-terraform/speedy/password"
}

data "aws_ssm_parameter" "tenant_id" {
  name = "/nhn-terraform/speedy/tenant_id"
}
