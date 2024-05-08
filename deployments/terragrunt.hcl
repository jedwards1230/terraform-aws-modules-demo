remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "terraform-aws-modules-demo-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-aws-modules-demo-lock-table"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

/* terraform {
  extra_arguments "dev_args" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]

    env_vars = {
      TF_VAR_var_from_environment = "value"
    }
  }
} */

# Build Resource Group
# Creates an AWS Resource Group to organize and manage AWS resources based on specific criteria, such as tags.
/* resource "aws_resourcegroups_group" "main" {
  name = local.name

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"]
      TagFilters = [
        {
          Key    = "awsApplication"
          Values = [local.common_tags["awsApplication"]]
        }
      ]
    })
  }

  tags = {
    awsApplication = var.project-name
  }
}
 */
