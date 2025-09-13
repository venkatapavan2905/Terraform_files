#main.tf 
locals {
  sanitized_project = lower(replace(var.KKE_PROJECT, "[^a-zA-Z0-9-]", "-"))
  sanitized_team    = lower(replace(var.KKE_TEAM, "[^a-zA-Z0-9-]", "-"))

  resource_prefix = "${local.sanitized_project}-${local.sanitized_team}"

  common_tags = {
    Project   = "datacenter"
    Team      = "dev-team"
    ManagedBy = "Terraform"
    Env       = var.KKE_ENVIRONMENT
  }
}

resource "aws_iam_user" "kke_user" {
  name = "${local.resource_prefix}-user"
  tags = local.common_tags
}

data "aws_iam_policy_document" "assume_ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "kke_role" {
  name               = "${local.resource_prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json

  tags = merge(
    local.common_tags,
    {
      RoleType = "EC2"
    }
  )
}

#outputs.tf
output "kke_user_name" {
  value       = aws_iam_user.kke_user.name
}

output "kke_role_name" {
  value       = aws_iam_role.kke_role.name
}

output "kke_tags_applied" {
  value       = aws_iam_user.kke_user.tags
}

#terraform.tfvars

#KKE_PROJECT     = "datacenter"
#KKE_TEAM        = "dev-team"
#KKE_ENVIRONMENT = "dev"

#variables.tf
variable "KKE_PROJECT" {
  type        = string
  validation {
    condition     = length(var.KKE_PROJECT) > 0
    error_message = "KKE_PROJECT cannot be empty. Please provide a valid project name."
  }

}

variable "KKE_TEAM" {
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.KKE_TEAM))
    error_message = "KKE_TEAM may only contain letters, digits, dashes, or underscores."
  }
}

variable "KKE_ENVIRONMENT" {
  type        = string
}