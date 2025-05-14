// Create a aws ami from already existing instance

resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-83e12327c4edef320"
  ]

  tags = {
    Name = "xfusion-ec2"
  }
}

resource "aws_ami_from_instance" "xfusion-ec2-ami" {
  name               = "xfusion-ec2-ami"
  source_instance_id = "i-f8a56d9e292abc090"
  tags = {
    Name = "xfusion-ec2-ami"
  }
}

//Query to check if the ami is available
/*
aws ec2 describe-images \
> --owners self \
> --filters "Name=name,Values=xfusion-ec2-ami" \
> --query "Images[*].{ID:ImageId,State:State,Name:Name}" \
> --output table
*/
