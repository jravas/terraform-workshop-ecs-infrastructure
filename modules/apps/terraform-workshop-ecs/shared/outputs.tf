output "vpc" {
  description = "VPC Information for the application"
  value       = module.vpc
}


output "ecr_repository_frontend" {
  description = "ECR repository information for the application"
  value       = module.api_docker_repository_frontend
}

output "ecr_repository_backend" {
  description = "ECR repository information for the application"
  value       = module.api_docker_repository_backend
}
