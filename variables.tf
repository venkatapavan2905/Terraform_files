variable "KKE_vpc" {
  type    = string
  default = "datacenter-vpc"
}

variable "KKE_sg" {
  type    = string
  default = "devops-sg"
}

resource "aws_security_group" "sg" {
  name = var.KKE_sg
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.KKE_vpc
  }
}

