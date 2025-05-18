resource "aws_s3_bucket" "xfusion-s3-26640" {
    bucket = "xfusion-s3-26640"
    ##acl = "public-read"
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

resource "aws_s3_bucket_policy" "xfusion_bucket_policy" {
  bucket = aws_s3_bucket.xfusion-s3-26640.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.xfusion-s3-26640.arn}/*"
      }
    ]
  })
}