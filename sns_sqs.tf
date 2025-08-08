resource "aws_sns_topic" "sns" {
  name = "nautilus-sns-topic"
}

resource "aws_sqs_queue" "sqs" {
  name = "nautilus-sqs-queue"
}

resource "aws_sns_topic_subscription" "sub" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs.arn
}
