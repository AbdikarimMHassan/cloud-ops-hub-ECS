variable "alb_name" {
    type = string
  
}

variable "public_subnets_ids" {
    type = list(string)
  
}

variable "alb_security_group" {
    type = list(string)
  
}

variable "alb_tg_name" {
    type = string
  
}

variable "target_type" {
    type = string
    
  
}
  

variable "vpc_id" {
    type = string
  
}

variable "certificate_arn" {
    type = string

}