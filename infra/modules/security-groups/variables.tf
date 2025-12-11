variable "vpc_id" {
    type = string
  

}

variable "alb_sg_name" {
    type = string
    default = "alb_sg_name"
  
}


variable "ecs_sg_name" {
    type = string
  
}

variable "app_port" {
    type = string
  
}