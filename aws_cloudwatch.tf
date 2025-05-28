resource "aws_cloudwatch_log_group" "loggroup" {
  name = "nautilus-log-group"
}

resource "aws_cloudwatch_log_stream" "logstream" {
  name           = "nautilus-log-stream"
  log_group_name = aws_cloudwatch_log_group.loggroup.name
}