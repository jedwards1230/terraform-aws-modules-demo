/**
 * # Elastic Kubernetes Service (EKS) Addons Module
 *
 * AWS - Elastic Kubernetes Service (EKS) cluster addons (e.g. autoscaler, metrics-server, etc.)
 */

terraform {
  required_version = ">= 1.8"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

