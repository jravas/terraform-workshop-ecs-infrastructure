module "terraform_workshop_ecs_shared" {
  source = "../../modules/apps/terraform-workshop-ecs/shared"

  project_name = "terraform-workshop-ecs"
}
