# Retrieve AWS Account ID using STS
data "aws_caller_identity" "current" {}

# Kinesis Stream
resource "aws_kinesis_stream" "devops_stream" {
  name             = "KKE_KINESIS_STREAM_NAME"
  shard_count      = 1
  retention_period = 24

  tags = {
    Environment = "KKE_ENVIRONMENT"
    Purpose     = "Stream ingestion"
  }

  provisioner "local-exec" {
    command = "echo 'Kinesis Stream KKE_KINESIS_STREAM_NAME created' > /home/bob/terraform/kinesis_creation.log"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "devops_bucket" {
  bucket = "KKE_S3_BUCKET_NAME"

  tags = {
    Environment = "KKE_ENVIRONMENT"
    Owner       = "devops"
  }

  provisioner "local-exec" {
    command = "echo 'S3 Bucket KKE_S3_BUCKET_NAME created' > /home/bob/terraform/s3_creation.log"
  }
}

# Save account identity to file
resource "null_resource" "account_identity" {
  provisioner "local-exec" {
    command = "echo 'Logged in as account ID:${data.aws_caller_identity.current.account_id}' > /home/bob/terraform/account_identity.log"
  }
}