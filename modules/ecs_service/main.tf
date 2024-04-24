locals {
  container_name = "${var.task_name}-container"
}

resource "aws_ecs_task_definition" "this" {
  family = "${var.task_name}-task"
  cpu    = var.task_cpu
  memory = var.task_memory

  container_definitions = jsonencode([
    {
      name        = local.container_name
      environment = var.environment
      image       = var.container_image
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = "tcp"
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  execution_role_arn = aws_iam_role.this.arn
}

resource "aws_ecs_service" "this" {
  name            = "${var.task_name}-service"
  cluster         = var.cluster_name
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.service_subnets
    security_groups  = var.service_security_groups
    assign_public_ip = var.service_assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = local.container_name
    container_port   = var.container_port
  }
}
