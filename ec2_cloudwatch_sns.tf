resource "aws_sns_topic" "sns_topic" {
  name = "datacenter-sns-topic"
}

resource "aws_instance" "ec2" {
  instance_type = "t2.micro"
  ami = "ami-0c02fb55956c7d316"
  associate_public_ip_address = true
  tags = {
    Name = "datacenter-ec2"
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name                = "datacenter-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 90
  alarm_description         = "This metric monitors ec2 cpu utilization"
  unit                      = "Percent"
  alarm_actions = [resource.aws_sns_topic.sns_topic.arn]
  dimensions = {
    InstanceId = aws_instance.ec2.id
  }
}