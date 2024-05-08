output "zone_id" {
  description = "The ID of the Route53 zone"
  value       = aws_route53_zone.this.zone_id
}
