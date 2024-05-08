terraform {
  source = "../../../modules/app_load_balancer"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnet_ids = ["subnet-12345678", "subnet-87654321"]
    vpc_id            = "vpc-12345678"
    security_group_id = "sg-12345678"
  }
}

inputs = {
  # --------------------------------------------------------------------------------------------------------------------
  # Required input variables
  # --------------------------------------------------------------------------------------------------------------------

  # Description: Deployment name (Project name + Environment)
  # Type: string
  deployment_name = include.env.locals.deployment_name

  # Description: The ID of the VPC
  # Type: string
  vpc_id = dependency.vpc.outputs.vpc_id

  # Description: value for the subnet ids
  # Type: list(string)
  subnet_ids = dependency.vpc.outputs.public_subnet_ids

  # Description: The ID of the security group
  # Type: string
  security_group_ids = [dependency.vpc.outputs.security_group_id]
}
