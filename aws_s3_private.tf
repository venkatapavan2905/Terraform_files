resource "aws_s3_bucket" "xfusion-bucket" {
    bucket = "xfusion-s3-23787"
    tags = {
        Name = "xfusion-s3-23787"
    }
}

resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.xfusion-bucket.id
    acl = "private"
}

resource "aws_s3_bucket_public_access_block" "xfusion_public_access" {
  bucket = aws_s3_bucket.xfusion-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}