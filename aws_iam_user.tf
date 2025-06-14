variable "KKE_user" {
  type    = string
  default = "iamuser_mark"
}

resource "aws_iam_user" "user" {
    name = var.KKE_user
}