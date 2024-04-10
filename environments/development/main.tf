resource "aws_ecs_cluster" "this" {
  name = local.cluster_name
}


module "rds" {
  source      = "../../modules/rds"
  vpc_id      = local.vpc_id
  environment = local.environment

  db_server_name         = "${local.project_name}-${local.environment}"
  db_server_type         = "postgres"
  db_server_version      = "14.10"
  db_instance_class      = "db.t4g.micro"
  allocated_storage      = 50
  is_publicly_accessible = true
  is_multi_az            = false
  subnets                = local.public_subnets
  allowed_address_groups = ["0.0.0.0/0"]
}

module "backend_task_definition" {
  source = "../../modules/ecs_service"

  cluster_name    = local.cluster_name
  task_name       = "${local.environment}-backend"
  container_image = "${local.backend_repository_url}:${local.environment}"

  desired_count = 1
  task_cpu      = 256
  task_memory   = 512

  container_port = 3000
  host_port      = 3000



  service_subnets          = local.public_subnets
  service_security_groups  = [aws_security_group.ecs_security_group.id]
  service_assign_public_ip = true
  target_group_arn         = aws_lb_target_group.backend_target_group.arn

  environment = local.backend_environment
}


module "frontend_task_definition" {
  source = "../../modules/ecs_service"

  cluster_name    = local.cluster_name
  task_name       = "${local.environment}-frontend"
  container_image = "${local.frontend_repository_url}:${local.environment}"

  desired_count = 1
  task_cpu      = 256
  task_memory   = 512

  container_port = 3000
  host_port      = 3000

  service_subnets          = local.public_subnets
  service_security_groups  = [aws_security_group.ecs_security_group.id]
  service_assign_public_ip = true
  target_group_arn         = aws_lb_target_group.frontend_target_group.arn

  environment = [{
    name  = "NEXT_PUBLIC_BACKEND_API"
    value = data.aws_lb.backend_lb.dns_name
  }]
}


