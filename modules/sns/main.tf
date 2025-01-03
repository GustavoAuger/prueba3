resource "aws_sns_topic" "sns_prueba3" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_prueba3.arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint
}
