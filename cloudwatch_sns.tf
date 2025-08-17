resource "aws_sns_topic" "sns_topic" {
  name = "nautilus-sns-topic"
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "nautilus-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  unit                = "Percent"
  actions_enabled     = true
  alarm_actions       = [resource.aws_sns_topic.sns_topic.arn]
}