terraform {
  source = "../../../modules/network"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  # --------------------------------------------------------------------------------------------------------------------
  # Required input variables
  # --------------------------------------------------------------------------------------------------------------------

  # Description: value for the environment
  # Type: string
  env = include.env.locals.deployment_name


  # --------------------------------------------------------------------------------------------------------------------
  # Optional input variables
  # Uncomment the ones you wish to set
  # --------------------------------------------------------------------------------------------------------------------

  # Description: value for the vpc cidr block
  # Type: string
  # vpc_cidr_block = "10.0.0.0/16"

  # Description: value for the private subnets CIDR blocks
  # Type: list
  private_subnets_cidr = ["10.0.0.0/19", "10.0.32.0/19"]

  # Description: value for the public subnets CIDR blocks
  # Type: list
  public_subnets_cidr = ["10.0.64.0/19", "10.0.96.0/19"]

  # Description: value for the private subnets tags
  # Type: map
  # private_subnet_tags = {}

  # Description: value for the public subnets tags
  # Type: map
  # public_subnet_tags = {}

  # Description: value for the subnet availability zones
  # Type: list
  subnet_availability_zones = ["us-east-1a", "us-east-1b"]
}
