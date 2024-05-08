terraform {
  required_version = ">= 1.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.4"
    }
  }
}

# Cloudfront requires an SSL certificate to be in the us-east-1 region
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}