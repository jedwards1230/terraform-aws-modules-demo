variable "deployment_name" {
  description = "Deployment name (Project name + Environment)"
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
variable "region" {
  description = "AWS region"
  type        = string
}

variable "task_config" {
  description = "Task configuration"
  type        = map(any)
  default = {
    cpu    = 256
    memory = 512
  }
}

variable "secrets" {
  description = "List of secret objects"
  type = list(object({
    keyname      = string
    secret_value = string
  }))
  default = null
}

variable "load_balancer_config" {
  description = "Load balancer configuration"
  type = object({
    container_port   = number
    target_group_arn = string
  })
  default = {
    container_port   = 3000
    target_group_arn = null
  }
}

variable "force_delete_ecr" {
  description = "Force delete ECR repository"
  type        = bool
  default     = true
}

variable "secret_recovery_window_in_days" {
  description = "Secret recovery window in days (Set to 0 for immediate deletion)"
  type        = number
  default     = 0
}

locals {
  container_name = "${var.deployment_name}-main"

  common_tags = {
    awsApplication = var.deployment_name
  }
}
