# Create IAM user
resource "aws_iam_user" "user" {
  name = "iamuser_ravi"

  tags = {
    Name = "iamuser_ravi"
  }
}

# Create IAM Policy
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_ravi"
  description = "IAM policy allowing EC2 read actions for ravi"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Read*"]
        Resource = "*"
      }
    ]
  })
}

# Policy Attachment
resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.policy.arn
}