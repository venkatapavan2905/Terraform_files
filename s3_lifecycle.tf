resource "aws_s3_bucket" "s3" {
    bucket = "datacenter-lifecycle-31624"
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
    bucket = aws_s3_bucket.s3.id
    rule {
        id = "datacenter-lifecycle-rule"
        status = "Enabled"
        expiration {
           days = 365
        }
        transition {
           days = 30
           storage_class = "STANDARD_IA"
        }
    } 
}