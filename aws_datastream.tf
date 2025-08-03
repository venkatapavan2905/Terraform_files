resource "aws_kinesis_stream" "stream" {
  name = "datacenter-stream"
  shard_count = 1
  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

}

### Kinesis with cloudwatch alarm

resource "aws_kinesis_stream" "kinesis" {
  name             = "datacenter-kinesis-stream"
  shard_count      = 1
  retention_period = 24
  shard_level_metrics = [
    "IncomingBytes",
    "IncomingRecords",
    "OutgoingBytes",
    "OutgoingRecords",
    "WriteProvisionedThroughputExceeded",
    "ReadProvisionedThroughputExceeded",
    "IteratorAgeMilliseconds"
  ]
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "datacenter-kinesis-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "WriteProvisionedThroughputExceeded"
  namespace           = "AWS/kinesis"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  dimensions = {
    StreamName = aws_kinesis_stream.kinesis.name
  }
}