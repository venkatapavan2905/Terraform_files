resource "tls_private_key" "xfusion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content              = tls_private_key.xfusion_key.private_key_pem
  filename             = "/home/bob/terraform/xfusion-kp.pem"
  file_permission      = "0600"
}

resource "aws_key_pair" "xfusion-kp" {
  key_name   = "xfusion-kp"
  public_key = tls_private_key.xfusion_key.public_key_openssh
}

resource "aws_instance" "xfusion-ec2" {
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    key_name = aws_key_pair.xfusion-kp.key_name
    associate_public_ip_address = true
    tags = {
        Name = "xfusion-ec2"
    }
}