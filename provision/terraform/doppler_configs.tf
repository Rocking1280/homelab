# project
resource "doppler_project" "homelab" {
  name = "homelab"
  description = "Homelab Project"
}

# environments
resource "doppler_environment" "homelab_dev" {
  project = doppler_project.homelab.name
  slug = "dev"
  name = "Development"
}

resource "doppler_environment" "homelab_gitlab" {
  project = doppler_project.homelab.name
  slug = "ci"
  name = "Gitlab CI"
}

resource "doppler_environment" "homelab_production" {
  project = doppler_project.homelab.name
  slug = "prd"
  name = "Production"
}

# branch configs
resource "doppler_config" "homelab_dev_container" {
  project = doppler_project.homelab.name
  environment = doppler_environment.homelab_dev.slug
  name = "dev_container"
}
