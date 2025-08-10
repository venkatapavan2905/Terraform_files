resource "aws_iam_user" "user" {
  name = "var.KKE_USER_NAME"
  provisioner "local-exec" {
    command = "echo KKE iamuser_anitha has been created successfully! >> /home/bob/terraform/KKE_user_created.log"
  }
}

