output "test_vpc_name" {
  value = aws_vpc.vpc.tags["Name"]
}

output "test_subnet_name" {
  value = aws_subnet.subnet.tags["Name"]
}