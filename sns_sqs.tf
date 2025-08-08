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

resource "aws_sqs_queue_policy" "nautilus_sqs_policy" {
  queue_url = aws_sqs_queue.sqs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "sqs:SendMessage",
        Resource  = aws_sqs_queue.sqs.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.sns.arn
          }
        }
      }
    ]
  })
}
