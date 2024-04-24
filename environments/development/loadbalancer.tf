# # Create a security group for ECS tasks
resource "aws_security_group" "ecs_security_group" {
  vpc_id = local.vpc_id
  ingress {
    description = "Allow traffic on port 3000 for ECS tasks"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Enables fetching image from ECR
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# # Create a load balancer
resource "aws_lb" "ecs_lb" {
  name               = "ecs-lb"
  internal           = false # Set to true if internal load balancer is needed
  load_balancer_type = "application"
  subnets            = local.public_subnets
  security_groups    = [aws_security_group.ecs_security_group.id]
}

data "aws_lb" "backend_lb" {
  name = aws_lb.ecs_lb.name
}

# Create listener for ALB
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }
}

# Create listener rules to route traffic to target groups based on path
resource "aws_lb_listener_rule" "backend_listener_rule" {
  listener_arn = aws_lb_listener.my_listener.arn
  priority     = 110

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/v1*", "/docs*"]
    }
  }
}

resource "aws_lb_target_group" "backend_target_group" {
  name        = "backend-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"

  health_check {
    path     = "/docs#"
    timeout  = 5  # Time to wait for a response from the target
    interval = 30 # Time between health checks (seconds)
  }
}


# Configure target group with port 3000
resource "aws_lb_target_group" "frontend_target_group" {
  name        = "frontend-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"

  health_check {
    path     = "/"
    timeout  = 5  # Time to wait for a response from the target
    interval = 30 # Time between health checks (seconds)
  }
}


