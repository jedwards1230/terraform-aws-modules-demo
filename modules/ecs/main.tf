/**
 * # Elastic Container Service (ECS) Module
 *
 * AWS - Orchestrates container deployments, ensuring they're running and manages their interactions with other AWS services.
 * 
 * View an [example](../../deployments/dev/ecs/terragrunt.hcl)
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
