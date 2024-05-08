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
  type        = map(string)
  default = {
    container_port   = 80
    target_group_arn = null
  }

}

locals {
  container_name = "${var.deployment_name}-main"

  common_tags = {
    awsApplication = var.deployment_name
  }
}
