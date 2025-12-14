# expose the certificate arn for the alb https listener
output "certificate_arn" {
  value       = data.aws_acm_certificate.domain_cert.arn
  description = "certificate arn for the alb"

}