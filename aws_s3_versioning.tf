resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "datacenter-s3-517"
  acl    = "private"

  tags = {
    Name = "datacenter-s3-517"
  }
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.s3_ran_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}