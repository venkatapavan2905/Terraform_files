resource "aws_cloudwatch_metric_alarm" "xfusion-alarm" {
  alarm_name                = "xfusion-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  unit                      = "Percent"
}

#Terraform file to create aws cloud watch alarm to monitor
#cpu utlization.