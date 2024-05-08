/**
 * # Network Module
 *
 * AWS - Network resources (e.g., VPC, Subnets, Internet Gateway, NAT Gateway, Route Tables)
 * 
 * View an [example](../../deployments/dev/vpc/terragrunt.hcl)
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
