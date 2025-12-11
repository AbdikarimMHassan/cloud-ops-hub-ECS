# create application load balancer to front the app
resource "aws_lb" "app_alb" {
    name = var.alb_name
    load_balancer_type = "application"
    internal = false
    subnets = var.public_subnets_ids
    security_groups = var.alb_security_group
    enable_deletion_protection = false

    tags = {
      name = "app-alb"
    }
}
# create the target group where the alb will send traffic to
resource "aws_lb_target_group" "alb_target_group" {
    name = var.alb_tg_name
    vpc_id = var.vpc_id
    target_type = var.target_type
    protocol = "HTTP"
    port = 80
    
    health_check {
      enabled             = true
      healthy_threshold   = 2
      unhealthy_threshold = 10
      timeout             = 30
      interval            = 60
      path                = "/"
      protocol            = "HTTP"
      matcher             = "200,301,302"
    }
}

# redirect any http traffic from the alb to the target group via https 
resource "aws_lb_listener" "http_redirector" {
  load_balancer_arn = aws_lb.app_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "redirect"
    redirect {
       port = 443
    protocol = "HTTPS"
    status_code = "HTTP_301"
      
    }
  } 
}
# forward traffic recieved on port 443 to the target group
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
  
}
