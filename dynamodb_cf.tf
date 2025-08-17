resource "aws_cloudformation_stack" "stack" {
  name          = "datacenter-dynamodb-stack"
  template_body = "local.cf_template_body"
  lifecycle {
    ignore_changes = [parameters]
  }
  parameters = {
    KKE_DYNAMODB_TABLE_NAME = "var.KKE_DYNAMODB_TABLE_NAME"
  }
}

/*
locals {
  cf_template_body = <<JSON
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources": {
    "MyDynamoDBTable": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "TableName": "datacenter-cf-dynamodb-table",
        "AttributeDefinitions": [
          {
            "AttributeName": "ID",
            "AttributeType": "S"
          }
        ],
        "KeySchema": [
          {
            "AttributeName": "ID",
            "KeyType": "HASH"
          }
        ],
        "ProvisionedThroughput": {
          "ReadCapacityUnits": 5,
          "WriteCapacityUnits": 5
        }
      }
    }
  }
}
JSON
}
*/