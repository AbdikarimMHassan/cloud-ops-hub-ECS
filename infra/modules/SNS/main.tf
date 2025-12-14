resource "aws_sns_topic" "alarm_topic" {
  name = var.sns_topic_name


}

resource "aws_sns_topic_subscription" "ecs_alarm" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_alert_endpoint


}