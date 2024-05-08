# Build Application Load Balancer
# Creates an ALB that distributes incoming application traffic across multiple targets, 
# such as ECS tasks, in multiple Availability Zones. 
resource "aws_lb" "this" {
  name                       = var.deployment_name
  internal                   = false
  enable_xff_client_port     = true
  preserve_host_header       = true
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = var.subnet_ids
  enable_deletion_protection = false
  tags                       = local.common_tags
}

resource "aws_lb_target_group" "http" {
  name        = "${var.deployment_name}-http"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  tags        = local.common_tags

  health_check {
    interval            = 120
    path                = "/health/"
    protocol            = "HTTP"
    matcher             = "200-299"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}
