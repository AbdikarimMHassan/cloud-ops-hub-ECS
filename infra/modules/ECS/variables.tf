variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "repository_name" {
  type = string

}
variable "ssm_parameter_name" {

}

variable "ssm_iamrole_name" {
  type = string

}
variable "log_group_name" {
  type = string

}

variable "log_region" {
  type = string
}

variable "retention_in_days" {
  type = string
}


variable "cluster_name" {
  type = string

}

variable "ecs_family" {
  type = string
}


variable "app_task_definition_cpu" {
  type = string

}


variable "app_task_definition_memory" {
  type = string

}

variable "ecs_exec_role_name" {
  type = string

}

variable "container_name" {
  type = string

}



variable "app_port" {
  type = number

}

variable "ecs_service_name" {
  type = string

}

variable "desired_count" {
  type = number

}


variable "private_app_subnet_ids" {

}

variable "ecs_security_group_ids" {
  type = string
}


variable "target_group_arn" {
  type = string

}

variable "http_listener_arn" {
  type = string

}

variable "https_listener_arn" {
  type = string

}