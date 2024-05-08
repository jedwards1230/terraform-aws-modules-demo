output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "The IDs of the private subnets"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "The IDs of the public subnets"
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "The ID of the security group"
}
