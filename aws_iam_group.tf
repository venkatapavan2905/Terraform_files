resource "aws_iam_group" "group" {
  name = "iamgroup_javed"
}

#Commands:
#1. aws iam list=groups
#2. aws iam get-group --group-name <group_name>
#3. aws iam create-group --group-name <group_name>
#4. aws iam delete-group --group-name <group_name>