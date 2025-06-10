resource "aws_s3_bucket" "my_bucket" {
  bucket = "xfusion-cp-22959"
  acl    = "private"

  tags = {
    Name = "xfusion-cp-22959"
  }
}

resource "aws_s3_object" "upload" {
  bucket = "xfusion-cp-22959"
  key    = "xfusion.txt"
  source = "/tmp/xfusion.txt"
  etag   = filemd5("/tmp/xfusion.txt")
}

#aws s3 ls --> to list s3 buckets
#aws s3 ls s3://xfusion-cp-22959/ --> to list contents of a bucket
#aws s3 ls s3://xfusion-cp-22959/ --recursive --> to list the contents of folders