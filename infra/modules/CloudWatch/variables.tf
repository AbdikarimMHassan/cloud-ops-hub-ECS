

variable "cpu_threshold" {
    type = number
  
}

variable "period" {
    type = number
  
}

variable "evaluation_periods" {
    type = number

  
}

variable "cluster_name" {
    type = string
  
}

variable "ecs_service_name" {
    type = string
}

variable "sns_topic_arn" {
    type = string
}
