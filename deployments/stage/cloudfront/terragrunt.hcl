terraform {
  source = "../../../modules/cloudfront"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

dependency "app_load_balancer" {
  config_path = "../app_load_balancer"

  mock_outputs = {
    dns_name = "my-load-balancer-12345678.us-east-1.elb.amazonaws.com"
  }
}

inputs = {
  # --------------------------------------------------------------------------------------------------------------------
  # Required input variables
  # --------------------------------------------------------------------------------------------------------------------

  # Description: Deployment name (Project name + Environment)
  # Type: string
  deployment_name = include.env.locals.deployment_name

  # Description: The DNS name of the target
  # Type: string
  target_dns_name = dependency.app_load_balancer.outputs.dns_name

  # --------------------------------------------------------------------------------------------------------------------
  # Optional input variables
  # Uncomment the ones you wish to set
  # --------------------------------------------------------------------------------------------------------------------

}
