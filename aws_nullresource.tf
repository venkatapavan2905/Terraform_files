# Add your code below
resource "null_resource" "s3_backup" {
  provisioner "local-exec" {
    command = <<EOT
           aws s3 cp s3://datacenter-bck-16302 /opt/s3-backup/ --recursive
        EOT
  }
}

resource "null_resource" "delete_s3_bucket" {
  depends_on = [null_resource.s3_backup]
  provisioner "local-exec" {
    command = <<EOT
          aws s3 rm s3://datacenter-bck-16302 --recursive
          aws s3api delete-bucket --bucket datacenter-bck-16302
        EOT
  }
}

#null_resource is a special type of resource type in terraform that does not create any resources in cloud but can manage the already created resources
#in the cloud from the local machine. This is can be used to run aws cli commands through terraform.
