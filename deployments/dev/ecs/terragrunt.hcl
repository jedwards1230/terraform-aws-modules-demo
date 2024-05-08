terraform {
  source = "../../../modules/ecs"
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

dependency "app_load_balancer" {
  config_path = "../app_load_balancer"

  mock_outputs = {
    target_group_arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"
  }
}

inputs = {
  # --------------------------------------------------------------------------------------------------------------------
  # Required input variables
  # --------------------------------------------------------------------------------------------------------------------

  # Description: Deployment name (Project name + Environment)
  # Type: string
  deployment_name = include.env.locals.deployment_name

  # Description: value for the subnet ids
  # Type: list(string)
  subnet_ids = dependency.vpc.outputs.public_subnet_ids

  # Description: The ID of the security group
  # Type: string
  security_group_ids = [dependency.vpc.outputs.security_group_id]

  # Description: AWS region
  # Type: string
  region = "us-west-2"

  # Description: Secrets
  # Type: list(object({
  #   keyname      = string
  #   secret_value = string
  # }))
  secrets = [
    {
      keyname = "key_1"
      secret_value  = "hello"
    },
    {
      keyname = "key_2",
      secret_value  = "world"
    }
  ]

  # Description: Load balancer configuration
  # Type: map(string)
  load_balancer_config = {
    container_port   = 80
    target_group_arn = dependency.app_load_balancer.outputs.target_group_arn
  }


  # --------------------------------------------------------------------------------------------------------------------
  # Optional input variables
  # Uncomment the ones you wish to set
  # --------------------------------------------------------------------------------------------------------------------

  # Description: Task configuration
  # Type: map
  # task_config = {"cpu":256,"memory":512}

}
