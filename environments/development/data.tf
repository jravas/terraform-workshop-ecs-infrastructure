data "terraform_remote_state" "shared" {
  backend = "remote"

  config = {
    organization = "Pipi-Corp"
    workspaces = {
      name = "shared"
    }
  }
}
