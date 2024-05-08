output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "The ARN of the load balancer target group"
  value       = aws_lb_target_group.http.arn
}
