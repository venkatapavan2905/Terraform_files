variable "KKE_iampolicy" {
  type    = string
  default = "iampolicy_anita"
}

resource "aws_iam_policy" "policy" {
  name = var.KKE_iampolicy
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}