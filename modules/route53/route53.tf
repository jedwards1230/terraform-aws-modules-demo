# Route 53 Hosted Zone
resource "aws_route53_zone" "this" {
  name = var.domain_name
}

