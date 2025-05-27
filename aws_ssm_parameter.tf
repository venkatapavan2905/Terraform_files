resource "aws_ssm_parameter" "ssm" {
  name  = "datacenter-ssm-parameter"
  type  = "String"
  value = "datacenter-value"
}