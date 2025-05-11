resource "aws_vpc" "nautilus-vpc" {
    cidr_block = "10.0.0.0/16"
    assign_generated_ipv6_cidr_block = true   //aws prvided ipv6 cidr block
    tags = {
        Name = "nautilus-vpc"
    }
}