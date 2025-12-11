output "ssm_parameter_name" {
    value = aws_ssm_parameter.image_tag.name
}


output "ssm_parameter_arn" {
    value = aws_ssm_parameter.image_tag.arn

}
output "ssm_parameter_type" {
    value = aws_ssm_parameter.image_tag.type
}