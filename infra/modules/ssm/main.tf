resource "aws_ssm_parameter" "image_tag" {
    name = var.ssm_parameter_name
    description = var.description
    type = var.ssm_parameter_type
    value = var.ssm_parameter_intial

    lifecycle {
      ignore_changes = [ value ]
     }

     tags = {
       Name = var.ssm_parameter_name
     }
  
}

