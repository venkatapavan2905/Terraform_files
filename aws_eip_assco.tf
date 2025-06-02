# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-406a503f1c48518e3"
  vpc_security_group_ids = [
    "sg-e9e04db6681401b25"
  ]

  tags = {
    Name = "devops-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  tags = {
    Name = "devops-ec2-eip"
  }
}

resource "aws_eip_association" "eip" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2_eip.id
}


# Command to check if the eip is associated to the instance:
# aws ec2 describe-addresses --region us-east-1 --filters "Name=tag:Name,Values=devops-ec2-eip"
