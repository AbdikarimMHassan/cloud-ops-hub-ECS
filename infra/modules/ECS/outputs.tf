output "execution_arn" {
  value = aws_iam_role.ecs_exec_role.arn

}


output "ecs_cluster_name" {
  value = aws_ecs_cluster.cloud_hub_app_cluster.name

}

output "ecs_service_name" {
  value = aws_ecs_service.cloud-hub-app-service.name
}




output "aws_ecs_task_definition_arn" {
  value = aws_ecs_task_definition.app_task_definition.arn
}

