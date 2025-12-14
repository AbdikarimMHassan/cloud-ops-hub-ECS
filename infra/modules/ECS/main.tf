# log group to send container logs 
resource "aws_cloudwatch_log_group" "cloud_hub_app_log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
}

# pull the ecr repostiory as data
data "aws_ecr_repository" "cloud-ops-hub-app" {
  name = var.repository_name
}

# pull the ssm parameter store for the image tags as data
data "aws_ssm_parameter" "image_tag" {
  name = var.ssm_parameter_name
}

#  IAM role to allow ecs to pull image from the ecr repo
resource "aws_iam_role" "ecs_exec_role" {
  name = var.ecs_exec_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# attach the IAM policy
resource "aws_iam_role_policy_attachment" "ecs_exec_role_policy" {
  role       = aws_iam_role.ecs_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# SSM read permission for ECS execution role
resource "aws_iam_role_policy" "ecs_ssm_read" {
  name = var.ssm_iamrole_name
  role = aws_iam_role.ecs_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ssm:GetParameter", "ssm:GetParameters"]
      Resource = "*"
    }]
  })
}

#  the ecs cluster for the task
resource "aws_ecs_cluster" "cloud_hub_app_cluster" {
  name = var.cluster_name
}

# create and define the task definitions
resource "aws_ecs_task_definition" "app_task_definition" {
  family                   = var.ecs_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.app_task_definition_cpu
  memory                   = var.app_task_definition_memory
  execution_role_arn       = aws_iam_role.ecs_exec_role.arn

  tags = {
    Application = "cloud-ops-hub"
  }

  container_definitions = jsonencode([
    {
      name = var.container_name

      image = "${data.aws_ecr_repository.cloud-ops-hub-app.repository_url}:${data.aws_ssm_parameter.image_tag.value}"

      essential = true

      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.log_region
          awslogs-group         = aws_cloudwatch_log_group.cloud_hub_app_log_group.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "cloud-hub-app-service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cloud_hub_app_cluster.id
  task_definition = aws_ecs_task_definition.app_task_definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets         = var.private_app_subnet_ids
    security_groups = [var.ecs_security_group_ids]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.app_port
  }

  depends_on = [var.http_listener_arn, var.https_listener_arn]
}