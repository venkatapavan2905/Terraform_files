resource "aws_dynamodb_table" "table" {
    name = "var.KKE_TABLE_NAME"
    billing_mode = "PAY_PER_REQUEST"
    #primary key also called as Hash Key
    hash_key = "taskId"
    attribute {
        name = "taskId"
        type = "S"
    }
    tags = {
        Name = "var.KKE_TABLE_NAME"
    }
}

resource "aws_dynamodb_table_item" "item1" {
    table_name = aws_dynamodb_table.table.name
    hash_key = "taskId"
    item = jsonencode({
        taskId = {"S" = "1" }
        description = {"S" = "Learn DynamoDB"}
        status = {"S" = "completed" }
    })
}

resource "aws_dynamodb_table_item" "item2" {
    table_name = aws_dynamodb_table.table.name
    hash_key = "taskId"
    item = jsonencode({
        taskId = {"S" = "2"}
        description = {"S" = "Build To-Do App"}
        status = {"S" = "in-progress"}
    })
}

#commands to verfiy the items added to table

#aws dynamodb get-item -table-name datacenter-tasks --key '{"taskId": {"S": "1"}}'

#aws dynamodb get-item --table-name datacenter-tasks --key '{"taskId": {"S": "2"}}'
