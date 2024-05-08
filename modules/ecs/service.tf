# Amazon Elastic Container Registry (ECR) Setup
# Stores Docker images used by ECS to launch containers.
resource "aws_ecr_repository" "main" {
  name = var.deployment_name
  tags = local.common_tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.main.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep only 5 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 5
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

# ECS Cluster Configuration
# Defines a logical grouping of tasks or services, providing a shared execution environment for them.
resource "aws_ecs_cluster" "main" {
  name = var.deployment_name
  tags = local.common_tags
}

# ECS Service Definition
# Manages the running instances of containerized applications, handling tasks such as task placement, scaling, and load balancing.
resource "aws_ecs_service" "main" {
  name            = var.deployment_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.family
  launch_type     = "FARGATE"
  desired_count   = 1
  tags            = local.common_tags

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.load_balancer_config.target_group_arn
    container_name   = var.load_balancer_config.container_name
    container_port   = var.load_balancer_config.container_port
  }
}
