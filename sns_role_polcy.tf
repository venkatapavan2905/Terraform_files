# Add your code below
resource "aws_sns_topic" "devops_sns_topic" {
  name = local.KKE_SNS_TOPIC_NAME
}

resource "aws_iam_role" "devops_sns_role" {
  name = local.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "devops_sns_policy" {
  name = local.KKE_POLICY_NAME
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sns:Publish",
      Resource = aws_sns_topic.devops_sns_topic.arn
    }]
  })
}

resource "aws_iam_policy_attachment" "example_attach" {
  name       = "attach-managed-policy"
  roles      = [aws_iam_role.devops_sns_role.name]
  policy_arn = aws_iam_policy.devops_sns_policy.arn
}


locals {
  KKE_SNS_TOPIC_NAME = "xfusion-sns-topic"
  KKE_ROLE_NAME      = "xfusion-sns-role"
  KKE_POLICY_NAME    = "xfusion-sns-policy"
}