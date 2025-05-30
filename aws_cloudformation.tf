resource "aws_cloudformation_stack" "devops-stack" {
  name = "devops-stack"
  template_body = jsonencode({
    Resources = {
      bucket = {
        Type = "AWS::S3::Bucket"
        Properties = {
          BucketName = "devops-bucket-20940"
          VersioningConfiguration = {
            Status = "Enabled"
          }
        }
      }
    }
  })
}