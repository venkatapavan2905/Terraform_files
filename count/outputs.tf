output "kke_instance_names" {
  value = [for i in aws_instance.ec2 : i.tags["Name"]]
}