resource "aws_instance" "ec2" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t2.micro"
  tags = {
    Name = "devops-ec2"
  }
}

resource "aws_eip" "devops_eip" {
  domain = "vpc"
  instance = aws_instance.ec2.id
  tags = {
    Name = "devops-eip"
  }
}


output "KKE_instance_name" {
  value = aws_instance.ec2.tags["Name"]
}

output "KKE_eip" {
  value = aws_eip.devops_eip.public_ip
}