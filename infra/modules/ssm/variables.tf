variable "ssm_parameter_name" {
  description = "name of the image ssm parameter"

}

variable "description" {
  type        = string
  description = "description of the ssm parameter"

}

variable "ssm_parameter_intial" {
  type        = string
  description = "intial value of the ssm parameter"

}

variable "ssm_parameter_type" {
  type        = string
  description = "type of ssm parameter"

}