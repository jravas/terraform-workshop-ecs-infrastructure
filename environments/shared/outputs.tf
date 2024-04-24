output "user_credentials" {
  description = "Credentials for all users"
  sensitive   = true
  value = [
    module.terraform_user,
    module.vlatko_vlahek_user,
    module.dino_stancic,
    module.josip_ravas_user,
  ]
}

output "terraform_workshop_ecs" {
  description = "Output all information from shared modules for customer portal app"
  value       = module.terraform_workshop_ecs_shared
}

