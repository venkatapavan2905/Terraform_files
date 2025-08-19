# S3 bucket for Firehose delivery
resource "aws_s3_bucket" "firehose_bucket" {
  bucket = "var.KKE_S3_BUCKET_NAME"
}

# IAM role for Firehose to assume
resource "aws_iam_role" "firehose_role" {
  name = "var.KKE_FIREHOSE_ROLE_NAME"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "firehose.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

# IAM policy to allow Firehose to write to S3
resource "aws_iam_policy" "firehose_s3_policy" {
  name        = "KKE_FIREHOSE_ROLE_NAME-policy"
  description = "Allows Firehose to write to S3"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = "${aws_s3_bucket.firehose_bucket.arn}/*"
      }
    ]
  })
}

# Attach policy to role
resource "aws_iam_role_policy_attachment" "firehose_s3_attach" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.firehose_s3_policy.arn
}

# Firehose delivery stream
resource "aws_kinesis_firehose_delivery_stream" "firehose_stream" {
  name        = "var.KKE_FIREHOSE_STREAM_NAME"
  destination = "s3"

  extended_s3_configuration {
    role_arn           = aws_iam_role.firehose_role.arn
    bucket_arn         = aws_s3_bucket.firehose_bucket.arn
    buffering_size     = 5
    buffering_interval = 300

    processing_configuration {
      enabled = true

      processors {
        type = "AppendDelimiterToRecord"

        parameters {
          parameter_name  = "Delimiter"
          parameter_value = "\n"
        }
      }
    }
  }

  depends_on = [aws_iam_role_policy_attachment.firehose_s3_attach]
}
