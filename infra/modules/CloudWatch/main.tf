resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilisation" {
  alarm_name          = "${var.ecs_service_name}-cpu-utilisation"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.cpu_threshold
  period              = var.period
  evaluation_periods  = var.evaluation_periods

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"
  statistic   = "Average"

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.ecs_service_name
  }

  alarm_actions = [var.sns_topic_arn]

}
