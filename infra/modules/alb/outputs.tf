output "alb_dns" {
    value = aws_lb.app_alb.dns_name
}

output "alb_arn" {
  value = aws_lb.app_alb.arn
}

output "target_group_arn" {
    value = aws_lb_target_group.alb_target_group.arn
  
}

output "http_listener_arn" {
    value = aws_lb_listener.http_redirector.arn
  
}


output "https_listener_arn" {
    value = aws_lb_listener.https_listener.arn
  
}

output "alb_zone_id" {
    value = aws_lb.app_alb.zone_id

}

output "alb_dns_name" {
    value = aws_lb.app_alb.dns_name
  
}