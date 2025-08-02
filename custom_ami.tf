# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-b9994ae7ec17c815e"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}

resource "aws_ami_from_instance" "ami" {
  name               = "xfusion-ec2-ami"
  source_instance_id = "i-a984821290ea59b77"
  tags = {
    Name = "xfusion-ec2-ami"
  }
}

resource "aws_instance" "ec2_new" {
  ami           = aws_ami_from_instance.ami.id
  instance_type = "t2.micro"
  tags = {
    Name = "xfusion-ec2-new"
  }
}