module "vpc" {
  source   = "../../../vpc"
  vpc_name = var.project_name
}


module "api_docker_repository_frontend" {
  source = "../../../ecr"

  name = "${var.project_name}-frontend"
}

module "api_docker_repository_backend" {
  source = "../../../ecr"

  name = "${var.project_name}-backend"
}
