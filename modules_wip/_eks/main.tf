/**
 * # Elastic Kubernetes Service (EKS) Module
 *
 * AWS - Elastic Kubernetes Service (EKS) cluster
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

