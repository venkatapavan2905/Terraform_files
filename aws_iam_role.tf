variable "KKE_iamrole" {
  type    = string
  default = "iamrole_siva"
}


resource "aws_iam_role" "role" {
  name = var.KKE_iamrole
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}