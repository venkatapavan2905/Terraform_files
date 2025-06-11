variable "KKE_vpc" {
  type    = string
  default = "datacenter-vpc"
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.KKE_vpc
  }
}