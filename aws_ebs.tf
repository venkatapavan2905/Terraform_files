#ebs volume
resource "aws_ebs_volume" "devops-volume" {
  type = "gp3"
  size = 2
  availability_zone = "us-east-1a"
  tags = {
    Name = "devops-volume"
  }
}

# ebs volume snapshot
resource "aws_ebs_snapshot" "devops-vol-ss" {
  description = "Devops Snapshot"
  volume_id   = aws_ebs_volume.devops-volume.id
  tags = {
    Name = "devops-vol-ss"
  }
}

#Availability Zone is mandatory. 
#String values must be quoted.