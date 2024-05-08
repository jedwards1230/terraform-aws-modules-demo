# Build ECS Task Definition
# Defines a task template for running containers in the ECS Cluster. This includes container image to use, 
# CPU and memory allocations, network mode, and IAM role for execution. The task definition specifies 
# the details of how the containers should operate, including their resource requirements and networking settings.
resource "aws_ecs_task_definition" "main" {
  family                   = var.deployment_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_config.cpu
  memory                   = var.task_config.memory
  execution_role_arn       = aws_iam_role.task_executor.arn
  tags                     = local.common_tags

  container_definitions = jsonencode([
    {
      name      = local.container_name,
      image     = aws_ecr_repository.this.repository_url,
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
          appProtocol   = "http"
        },
        {
          containerPort = 443,
          hostPort      = 443,
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ],
      secrets = [
        for secret_obj in var.secrets : {
          name      = secret_obj.keyname
          valueFrom = aws_secretsmanager_secret.this[lookup(secret_obj, "keyname")].arn
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.log_group.name,
          "awslogs-region"        = var.region,
          "awslogs-stream-prefix" = "ecs",
        }
      }
    },
  ])
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${local.container_name}"
  retention_in_days = 30 // Adjust the retention period as needed
}
