terraform {
  backend "remote" {
    organization = "Pipi-Corp"

    workspaces {
      name = "development"
    }
  }
}
