resource "aws_security_group" "datacenter-sg" {
    name = "datacenter-sg"
    description = "Security group for Nautilus App Servers"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "http"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "SSH"
        cidr_blocks = ["0.0.0.0/0"]
    }
}