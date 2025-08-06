resource "aws_instance" "ec2" {
    instance_type = "t2.micro"
    ami = data.aws_ami.ami
    iam_instance_profile = aws_iam_instance_profile.profile.name
    tags = {
        Name = "autilus-ec2"
    }
}

resource "aws_s3_bucket" "s3" {
    bucket = var.KKE_BUCKET_NAME
}

resource "aws_iam_role" "role" {
  name = var.KKE_ROLE_NAME
  assume_role_policy = jsondecode({
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
    policy = jsondecode({
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Action = [
                "S3:PutObject"
            ]

            Resource = "${aws_s3_bucket.s3.arn}/*"
        }
        ]
     })
}

resource "aws_iam_role_policy_attachment" "attacgment" {
    role = aws_iam_role.role.name
    policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "profile" {
    name = "nautilus-instance-profile"
    role = aws_iam_role.role.name
}



data "aws_ami" "ami" {
    most_recent = true
    owners = ["mazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
variable "KKE_BUCKET_NAME" {
    type = string
}

variable "KKE_ROLE_NAME" {
    type = string
}

variable "KKE_POLICY_NAME" {
    type = string  
}

/*
KKE_BUCKET_NAME = "nautilus-logs-14697"
KKE_ROLE_NAME = "nautilus-role"
KKE_POLICY_NAME = "nautilus-access-policy"
*/
