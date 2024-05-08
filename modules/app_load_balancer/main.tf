/**
 * # Application Load Balancer Module
 *
 * AWS - Application Load Balancer (ALB) module
 * 
 * View an [example](../../deployments/dev/app_load_balancer/terragrunt.hcl)
 */

terraform {
  required_version = ">= 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4"
    }
  }
}
