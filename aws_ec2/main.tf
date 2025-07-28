resource "aws_vpc" "vpc" {
    cidr_block = var.KKE_VPC_CIDR
    tags = {
        Name = "nautilus-priv-vpc"
    }
}

resource "aws_subnet" "subnet" {
    cidr_block = var.KKE_SUBNET_CIDR
    vpc_id = aws_vpc.vpc.id
    map_public_ip_on_launch = false
    tags = {
        Name = "nautilus-priv-subnet"
    }
}

resource "aws_security_group" "priv_sg" {
    name = "priv_sg"
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["10.0.0.0/16"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "priv_sg"
    }
}

resource "aws_instance" "ec2" {
    ami = "ami-0c101f26f147fa7fd"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet.id
    vpc_security_group_ids = [aws_security_group.priv_sg.id]
    tags = {
        Name = "nautilus-priv-ec2"
    }
}