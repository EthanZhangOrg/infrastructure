resource "aws_route53_record" "route53_record" {
  zone_id = var.route53_record_zone_id
  name    = var.route53_record_name
  type    = var.route53_record_type

  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = true
  }
}