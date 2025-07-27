resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = var.subnet_name
    }
}