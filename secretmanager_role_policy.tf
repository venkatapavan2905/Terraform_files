# Add your code below
# Add your code below
resource "aws_secretsmanager_secret" "secret" {
  name = var.KKE_SECRET_NAME
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = var.KKE_SECRET_VALUE
}

resource "aws_iam_role" "role" {
  name = var.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "inline_policy" {
  name = var.KKE_POLICY_NAME
  role = aws_iam_role.role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "secretsmanager:GetSecretValue"
      ],
      Resource = aws_secretsmanager_secret.secret.arn
    }]
  })
}


variable "KKE_SECRET_NAME" {
    type = string
    default = "datacenter-app-secret"
}

variable "KKE_SECRET_VALUE" {
    type = string
    default = "{\"db_user\":\"admin\",\"db_pass\":\"supersecret\"}"
}

variable "KKE_ROLE_NAME" {
    type = string
    default = "datacenter-app-role"
}

variable "KKE_POLICY_NAME" {
    type = string
    default = "datacenter-app-policy"
}

#There is a difference between attaching inline polcies and managed polices.