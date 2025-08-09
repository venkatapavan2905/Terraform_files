resource "aws_iam_role" "role" {
    name = var.KKE_ROLE_NAME
    # MAndatory field
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_policy" "policy" {
    name = var.KKE_POLICY_NAME
    # mandatory field
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "ec2:DescribeInstances"
                ]
                Effect = "Allow"
                Resource = "*"
            },
        ]
    })
}

resource "aws_iam_policy_attachment" "attach" {
    name = "attach"
    # plural and list type
    roles = [aws_iam_role.role.name]
    # singular and string type
    policy_arn = aws_iam_policy.policy.arn
}

variable "KKE_ROLE_NAME" {
    type = string
}

variable "KKE_POLICY_NAME" {
    type = string
}

output "kke_iam_role_name" {
    value = aws_iam_role.role.name
}

output "kke_iam_policy_name" {
    value = aws_iam_policy.policy.name
}