module "vpc" {
  source              = "./modules/vpc"
  vpc_name            = local.vpc_name
  vpc_cidr            = local.vpc_cidr
  public_subnets      = local.public_subnets_config
  private_app_subnets = local.private_subnets_config
}


module "security_groups" {
  source      = "./modules/security-groups"
  vpc_id      = module.vpc.vpc_id
  ecs_sg_name = var.ecs_sg_name
  app_port    = var.app_port
  alb_sg_name = var.alb_sg_name

}
module "alb" {
  source             = "./modules/alb"
  alb_name           = var.alb_name
  vpc_id             = module.vpc.vpc_id
  public_subnets_ids = module.vpc.public_subnet_ids
  alb_security_group = [module.security_groups.alb_security_group]
  target_type        = var.target_type
  alb_tg_name        = var.alb_tg_name
  certificate_arn    = module.acm.certificate_arn
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name

}

module "Route53" {
  source       = "./modules/Route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  domain_name  = var.domain_name
}


module "ecs" {
  source                 = "./modules/ECS"
  vpc_id                 = module.vpc.vpc_id
  repository_name        = var.repository_name
  ssm_parameter_name     = var.ssm_parameter_name
  ssm_iamrole_name       = var.ssm_iamrole_name
  private_app_subnet_ids = module.vpc.private_app_subnets_ids
  ecs_security_group_ids = module.security_groups.ecs_security_group
  alb_sg_id              = module.security_groups.alb_security_group
  http_listener_arn      = module.alb.http_listener_arn
  https_listener_arn     = module.alb.https_listener_arn
  target_group_arn       = module.alb.target_group_arn

  cluster_name               = var.cluster_name
  ecs_family                 = var.ecs_family
  ecs_exec_role_name         = var.ecs_exec_role_name
  app_task_definition_cpu    = var.app_task_definition_cpu
  app_task_definition_memory = var.app_task_definition_memory

  container_name = var.container_name
  app_port       = var.app_port

  ecs_service_name = var.ecs_service_name
  desired_count    = var.desired_count

  log_group_name    = var.log_group_name
  log_region        = var.log_region
  retention_in_days = var.retention_in_days

}

module "sns" {
  source                 = "./modules/SNS"
  sns_topic_name         = var.sns_topic_name
  sns_subscription_alarm = var.sns_subscription_alarm
  sns_protocol           = var.sns_protocol
  sns_alert_endpoint     = var.sns_alert_endpoint
}


module "CloudWatch" {
  source             = "./modules/CloudWatch"
  cpu_threshold      = var.cpu_threshold
  period             = var.period
  evaluation_periods = var.evaluation_periods
  cluster_name       = module.ecs.ecs_cluster_name
  ecs_service_name   = module.ecs.ecs_service_name
  sns_topic_arn      = module.sns.sns_topic_arn

}

module "ssm" {
  source               = "./modules/ssm"
  ssm_parameter_name   = "/cloud-ops-hub/image-tag"
  description          = " store the commit sha ID of every github actions workflow deployment"
  ssm_parameter_type   = "String"
  ssm_parameter_intial = "Initial"
}
