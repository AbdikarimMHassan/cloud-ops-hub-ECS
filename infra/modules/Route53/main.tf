resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name

}


resource "aws_route53_record" "alb_alias" {
  name    = var.domain_name
  zone_id = aws_route53_zone.hosted_zone.zone_id
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true

  }



}