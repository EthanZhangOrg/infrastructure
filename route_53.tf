resource "aws_route53_record" "route53_record" {
  zone_id = var.route53_record_zone_id
  name    = var.route53_record_name
  type    = var.route53_record_type
  ttl     = var.route53_record_ttl
  records = [aws_eip.eip.public_ip]
}

resource "aws_eip" "eip" {
  instance = aws_instance.webapp.id
  vpc      = var.aws_eip_vpc
}