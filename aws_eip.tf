variable "KKE_eip" {
  type    = string
  default = "nautilus-eip"
}

resource "aws_eip" "nautilus-eip" {
    domain = "vpc"
    tags = {
        Name = var.KKE_eip
    }
}