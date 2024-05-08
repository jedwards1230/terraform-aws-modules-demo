variable "deployment_name" {
  description = "Deployment name (Project name + Environment)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "subnet_ids" {
  type        = list(string)
  description = "value for the subnet ids"
}
variable "security_group_ids" {
  description = "value for the security group ids"
  type        = list(string)
}

locals {
  common_tags = {
    awsApplication = var.deployment_name
  }
}