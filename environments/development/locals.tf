locals {
  environment  = "development"
  project_name = "terraform-workshop-ecs"
  cluster_name = "development-cluster"

  vpc_id          = data.terraform_remote_state.shared.outputs.terraform_workshop_ecs.vpc.vpc_id
  public_subnets  = data.terraform_remote_state.shared.outputs.terraform_workshop_ecs.vpc.public_subnets
  private_subnets = data.terraform_remote_state.shared.outputs.terraform_workshop_ecs.vpc.private_subnets

  backend_repository_url  = data.terraform_remote_state.shared.outputs.terraform_workshop_ecs.ecr_repository_backend.repository_url
  frontend_repository_url = data.terraform_remote_state.shared.outputs.terraform_workshop_ecs.ecr_repository_frontend.repository_url

  backend_environment = [
    {
      name  = "API_PORT"
      value = "3000"
    },
    {
      name  = "DB_HOST"
      value = module.rds.rds_address
    },
    {
      name  = "DB_PORT"
      value = module.rds.rds_port
    },
    {
      name  = "DB_NAME"
      value = module.rds.rds_username
    },
    {
      name  = "DB_USERNAME"
      value = module.rds.rds_username
    },
    {
      name  = "DB_PASSWORD"
      value = module.rds.rds_password
    },
    {
      name  = "WEB_URL"
      value = data.aws_lb.backend_lb.dns_name
    }
  ]
}
