resource "aws_s3_bucket" "buckets" {
  for_each = var.KKE_ENV_TAGS
  bucket   = each.value.Name
  tags = {
    Name        = each.value.Name
    Environment = each.value.Environment
    Owner       = each.value.Owner
    Backup      = each.value.Backup ? "true" : "false"
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  dynamic "lifecycle_rule" {
    for_each = each.value.Backup ? [1] : []
    content {
      id      = "MoveToGlacier"
      enabled = true

      transition {
        days          = 30
        storage_class = "GLACIER"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  for_each = var.KKE_ENV_TAGS

  bucket = aws_s3_bucket.buckets[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.buckets[each.key].arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket.buckets]
  lifecycle {
    create_before_destroy = true
  }
}

variable "KKE_ENV_TAGS" {
  type = map(object({
    Name        = string
    Environment = string
    Owner       = string
    Backup      = bool
  }))
  default = {
    dev = {
      Name        = "devops-dev-bucket-31190"
      Environment = "Dev"
      Owner       = "Alice"
      Backup      = false
    }
    staging = {
      Name        = "devops-staging-bucket-31190"
      Environment = "Staging"
      Owner       = "Bob"
      Backup      = true
    }
    Prod = {
      Name        = "devops-prod-bucket-31190"
      Environment = "Prod"
      Owner       = "Carol"
      Backup      = true
    }
  }
}

output "kke_bucket_name" {
  value = [for b in aws_s3_bucket.buckets : b.bucket]
}