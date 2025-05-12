resource "aws_eip" "nautilus-eip" {
    domain = "vpc"
    tags = {
        Name = "nautilus-eip"
    }
}