resource "tls_private_key" "devops_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content              = tls_private_key.devops_key.private_key_pem
  filename             = "<filepath>/devops-kp.pem"
  file_permission      = "0600"
}

resource "aws_key_pair" "devops_kp" {
  key_name   = "devops-kp"
  public_key = tls_private_key.devops_key.public_key_openssh
}