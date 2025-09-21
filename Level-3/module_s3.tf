resource "aws_s3_bucket" "bucket" {
    bucket = var.bucket_name
    tags = {
        Name = var.bucket_name
        Project = "StaticWeb"
    }
}

resource "aws_s3_bucket_website_configuration" "config" {
    bucket = aws_s3_bucket.bucket.id
    index_document {
        suffix = var.index_document
    }
}

resource "aws_s3_bucket_policy" "policy" {
    bucket = aws_s3_bucket.bucket.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = "S3:GetObject"
                Resource = "${aws_s3_bucket.bucket.arn}/*"
            }
        ]
    })
}

output "website_url" {
    value = "http://aws:4566/${var.bucket_name}/${var.index_document}"
}

output "bucket_name" {
    value = aws_s3_bucket.bucket.id
}

variable "bucket_name" {
    type = string
}

variable "index_document" {
    type = string
}

module "s3" {
  source         = "./modules/s3-static-site"
  bucket_name    = "xfusion-web-31419"
  index_document = "index.html"
}

resource "aws_s3_object" "upload" {
  bucket = module.s3.bucket_name
  key    = "index.html"
  source = "${path.module}/index.html"
  acl    = "public-read"
}

output "website_url" {
  value = module.s3.website_url
}