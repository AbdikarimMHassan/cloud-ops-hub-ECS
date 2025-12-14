# ACM Module
variable "domain_name" {
  type        = string
  description = "website domain for acm and Route53"

}

# ALB Module
variable "alb_name" {
  type        = string
  description = "name of the alb"

}

variable "alb_tg_name" {
  type = string

}


variable "target_type" {
  type = string
}

# Security group module

variable "alb_sg_name" {
  type = string

}

variable "ecs_sg_name" {
  type = string

}

variable "app_port" {
  type = string

}


# ECS Module

variable "log_group_name" {
  type = string

}

variable "log_region" {
  type = string

}

variable "retention_in_days" {
  type = string
}

variable "repository_name" {
  type = string

}

variable "ssm_parameter_name" {
  type = string

}

variable "ssm_iamrole_name" {
  type = string
}

variable "cluster_name" {
  type = string

}

variable "ecs_family" {
  type = string
}



variable "ecs_exec_role_name" {
  type = string
}


variable "app_task_definition_cpu" {
  type = string

}


variable "app_task_definition_memory" {
  type = string
}


variable "container_name" {
  type = string

}


variable "ecs_service_name" {
  type = string

}

variable "desired_count" {
  type = number

}

# SNS Module
variable "sns_topic_name" {
  type = string

}


variable "sns_subscription_alarm" {
  type = string

}

variable "sns_protocol" {
  type = string

}

variable "sns_alert_endpoint" {
  type = string

}

# CloudWatch module

variable "cpu_threshold" {
  type = number

}

variable "period" {
  type = number

}

variable "evaluation_periods" {
  type = number


}