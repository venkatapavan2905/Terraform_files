locals {
    workspace = terraform.workspace
    api_names = [for name in var.KKE_API_NAMES : "${local.workspace}-${name}"]
    log_group_names = [for name in local.api_names : "/aws/apigateway/${name}"]
}

resource "aws_api_gateway_rest_api" "api" {
    count = length(local.api_names)
    name = local.api_names[count.index]
    provisioner "local-exec" {
        command = "echo 'Created API Gateway ${local.api_names[count.index]} in workspace ${local.workspace}' >> /home/bob/terraform/apigateway.log"
    }
}

resource "aws_cloudwatch_log_group" "loggroup" {
    count = length(local.log_group_names)
    name = local.log_group_names[count.index]
    retention_in_days  = 7
    provisioner "local-exec" {
        command = "echo 'Created Log Group ${local.log_group_names[count.index]} in workspace ${local.workspace}' >> /home/bob/terraform/loggroups.log"
    }
}

output "kke_api_gateway_names" {
    value = [for api in aws_api_gateway_rest_api.api: api.name]
}

output "kke_log_group_names" {
    value = [for log in aws_cloudwatch_log_group.loggroup: log.name]
}

variable "KKE_API_NAMES" {
    type = list(string)
}

#KKE_API_NAMES = ["xfusion-api-1", "xfusion-api-2"]