# Dynamically Create Secrets Manager entries and their versions
resource "aws_secretsmanager_secret" "this" {
  for_each = { for s in var.secrets : s.keyname => s }

  name                    = "${var.deployment_name}-${each.key}"
  recovery_window_in_days = var.secret_recovery_window_in_days
  description             = "Secret for ${each.key}"
  tags                    = local.common_tags
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
