resource "aws_dynamodb_table" "nautilus-users" {
  name         = var.KKE_DYNAMODB_TABLE_NAME
  hash_key     = "nautilus_id"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "nautilus_id"
    type = "S"
  }
  tags = {
    Environment = var.KKE_ENVIRONMENT
  }
}

resource "aws_sns_topic" "updates" {
  name = var.KKE_SNS_TOPIC_NAME
  tags = {
    Environment = var.KKE_ENVIRONMENT
  }
}

resource "aws_ssm_parameter" "ssm" {
  name  = var.KKE_SSM_PARAM_NAME
  type  = "String"
  value = "asdfghjkl"
  tags = {
    Environment = var.KKE_ENVIRONMENT
  }
}

output "kke_dynamodb_table_name" {
    value = aws_dynamodb_table.nautilus-users.name
}

output "kke_sns_topic_arn" {
    value = aws_sns_topic.updates.arn
}

output "kke_ssm_parameter_name" {
    value = aws_ssm_parameter.ssm.name
}

#KKE_ENVIRONMENT = "dev"
#KKE_DYNAMODB_TABLE_NAME = "devops-app-table"
#KKE_SNS_TOPIC_NAME = "devops-app-topic"
#KKE_SSM_PARAM_NAME = "/devops/app/config"

variable "KKE_ENVIRONMENT" {
    type = string
}

variable "KKE_DYNAMODB_TABLE_NAME" {
    type = string
}

variable "KKE_SNS_TOPIC_NAME" {
    type = string
}

variable "KKE_SSM_PARAM_NAME" {
    type = string
}