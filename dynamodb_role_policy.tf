resource "aws_dynamodb_table" "table" {
    name = "var.KKE_TABLE_NAME"
    hash_key = "devops_id"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
        name = "devops_id"
        type = "S"
    }
}

resource "aws_iam_role" "role" {
    name = var.KKE_ROLE_NAME
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_policy" "policy" {
    name = var.KKE_POLICY_NAME
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "dynamodb:GetItem",
                    "dynamodb:Scan",
                    "dynamodb:Query"
                ],
                Effect = "Allow"
                Resource = aws_dynamodb_table.table.arn
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "attach" {
    role = aws_iam_role.role.name
    policy_arn = aws_iam_policy.policy.arn
}