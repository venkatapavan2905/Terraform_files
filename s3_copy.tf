# To copy or sync from one S3 bucket to another

resource "aws_s3_bucket" "wordpress_bucket" {
  bucket = "devops-s3-31224"
}

resource "aws_s3_bucket_acl" "wordpress_bucket_acl" {
  bucket = aws_s3_bucket.wordpress_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "s3_new" {
  bucket = var.KKE_BUCKET
}

resource "aws_s3_bucket_acl" "s3_new_acl" {
  bucket = aws_s3_bucket.s3_new.id
  acl    = "private"
}

resource "null_resource" "s3_data_sync" {
  provisioner "local-exec" {
    command = "aws s3 sync s3://devops-s3-31224 s3://${var.KKE_BUCKET} --exact-timestamps"
  }

  depends_on = [aws_s3_bucket.s3_new]
}

variable "KKE_BUCKET" {
  type = string
  default = "devops-sync-19140"
}