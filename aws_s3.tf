resource "aws_s3_bucket" "xfusion-s3-26640" {
    bucket = "xfusion-s3-26640"
    tags = {
        Name = "xfusion-s3-26640"
    }
}

resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.xfusion-s3-26640.id
    acl = "public-read"
}

resource "aws_s3_bucket_public_access_block" "xfusion_public_access" {
  bucket = aws_s3_bucket.xfusion-s3-26640.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}