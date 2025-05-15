resource "aws_ebs_volume" "devops-volume" {
  type = "gp3"
  size = 2
  availability_zone = "us-east-1a"
  tags = {
    Name = "devops-volume"
  }
}

#Availability Zone is mandatory. 
#String values must be quoted.