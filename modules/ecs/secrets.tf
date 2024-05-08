# Dynamically Create Secrets Manager entries and their versions
resource "aws_secretsmanager_secret" "this" {
  for_each = { for s in var.secrets : s.keyname => s }

  name        = "${var.deployment_name}-${each.key}"
  description = "Secret for ${each.key}"
  tags        = local.common_tags
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each = { for s in var.secrets : s.keyname => s }

  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = each.value.secret_value
}

# Updated IAM policy to allow access to all secrets
resource "aws_iam_policy" "secrets_access" {
  name        = "${var.deployment_name}-secrets-access"
  description = "Allow ECS tasks to access secrets"
  tags        = local.common_tags

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Effect   = "Allow",
        Resource = [for secret in aws_secretsmanager_secret.this : secret.arn]
      }
    ]
  })
}

# Build ECS Task Execution Role
# Creates an IAM role that grants the ECS tasks permissions to make AWS API calls on your behalf.
# This role is used by ECS tasks to interact with other AWS services such as ECR for image pulling 
# and CloudWatch for logging.
resource "aws_iam_role" "task_executor" {
  name = "${var.deployment_name}-ecsTaskExecutionRole"
  tags = local.common_tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  # Attach additional policy for logs:CreateLogGroup permission
  inline_policy {
    name = "ecsTaskExecutionRole-InlinePolicy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Action   = "logs:CreateLogGroup",
          Effect   = "Allow",
          Resource = "*"
        }
      ]
    })
  }
}

resource "aws_iam_role_policy_attachment" "secrets_access_attachment" {
  role       = aws_iam_role.task_executor.name
  policy_arn = aws_iam_policy.secrets_access.arn
}

# Attach AmazonECSTaskExecutionRolePolicy to ECS Task Execution Role
# Associates a predefined AWS policy (AmazonECSTaskExecutionRolePolicy) with the ECS Task Execution Role. 
# This policy provides the necessary permissions for the ECS tasks to interact with AWS services needed 
# during task execution, such as pulling images from ECR and sending logs to CloudWatch.
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.task_executor.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
